From: Paolo Bonzini <pbonzini@redhat.com>
Subject: 0xB16B00B5? Really? (was Re: Move hyperv out of the drivers/staging/
 directory)
Date: Fri, 13 Jul 2012 12:23:13 +0200
Message-ID: <4FFFF711.8040003@redhat.com>
References: <1316708240-25048-1-git-send-email-kys@microsoft.com> <20110922170450.GA4490@suse.de> <6E21E5352C11B742B20C142EB499E048081E935D@TK5EX14MBXC124.redmond.corp.microsoft.com> <20110922173618.GA5624@suse.de> <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com> <20111004170415.GA1320@suse.de> <6E21E5352C11B742B20C142EB499E048081EB86F@TK5EX14MBXC124.redmond.corp.microsoft.com> <20111004193414.GA15672@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111004193414.GA15672@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Greg KH <gregkh@suse.de>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Il 04/10/2011 21:34, Greg KH ha scritto:
> diff --git a/drivers/staging/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> similarity index 99%
> rename from drivers/staging/hv/hyperv_vmbus.h
> rename to drivers/hv/hyperv_vmbus.h
> index 3d2d836..8261cb6 100644
> --- a/drivers/staging/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -28,8 +28,7 @@
>  #include <linux/list.h>
>  #include <asm/sync_bitops.h>
>  #include <linux/atomic.h>
> -
> -#include "hyperv.h"
> +#include <linux/hyperv.h>
>  
>  /*
>   * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent

git's rename detection snips away this gem:

+#define HV_LINUX_GUEST_ID_LO		0x00000000
+#define HV_LINUX_GUEST_ID_HI		0xB16B00B5
+#define HV_LINUX_GUEST_ID		(((u64)HV_LINUX_GUEST_ID_HI << 32) | \
+					   HV_LINUX_GUEST_ID_LO)

Somone was trying to be funny, I guess.

KY, I suppose you have access to Hyper-V code or can ask someone who does.
Is this signature actually used in the Hyper-V host code?

Paolo
