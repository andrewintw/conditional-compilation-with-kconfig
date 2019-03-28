#include <stdio.h>

int main()
{
	printf("Model A support features:\n");

#if defined(SUPPORT_WIFI)
	printf("* WiFi\n");
#endif

#if defined(SUPPORT_NAT)
	printf("* NAT\n");
#endif

#if defined(SUPPORT_IPV6)
	printf("* IPv6\n");
#endif

#if defined(SUPPORT_VPN)
	printf("* VPN\n");
#endif

	return 0;
}
