From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: hv: Cleanup the guest ID computation
Date: Tue, 24 Jul 2012 23:28:22 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9236A899F@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1343171518-15189-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343171518-15189-1-git-send-email-kys@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: K. Y. Srinivasan [mailto:kys@microsoft.com]
> Sent: Tuesday, July 24, 2012 7:12 PM
> To: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; olaf@aepfle.de;
> apw@canonical.com
> Cc: KY Srinivasan
> Subject: [PATCH 1/1] Drivers: hv: Cleanup the guest ID computation
> 
> The current guest ID string in use in vmbus driver does not conform
> to the MSFT guidelines on guest ID. MSFT currently does not specify
> Linux specific guidelines. MSFT however has plans to publish Linux
> specific guidelines. This implementation conforms to the yet unpublished
> Linux specific guidelines for guest ID. This implementation also broadly
> conforms to the current guidelines as well.
> 
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

Haiyang reviewed this code but I forgot include the

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

line. Greg, do you want me to resend this patch with that addition.

Regards,

K. Y
