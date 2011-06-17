From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/5] staging: hv: fix some white spaces in netvsc driver
Date: Fri, 17 Jun 2011 16:43:27 +0000
Message-ID: <A1F3067C9B68744AA19F6802BAB8FFDC09612D20@TK5EX14MBXC227.redmond.corp.microsoft.com>
References: <1308322688-9796-1-git-send-email-haiyangz@microsoft.com>
	<20110617180324.1eeb2ea0@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110617180324.1eeb2ea0@absol.kitzblitz>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Nicolas Kaiser <nikai@nikai.net>
Cc: "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

> -----Original Message-----
> From: Nicolas Kaiser [mailto:nikai@nikai.net]
> Sent: Friday, June 17, 2011 12:03 PM
> To: Haiyang Zhang
> Cc: Hank Janssen; KY Srinivasan; Abhishek Kane (Mindtree Consulting
> PVT LTD); gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 1/5] staging: hv: fix some white spaces in netvsc
> driver
> 
> * Haiyang Zhang <haiyangz@microsoft.com>:
> > diff --git a/drivers/staging/hv/netvsc.c
> b/drivers/staging/hv/netvsc.c
> > index 0ae35e7..b6e1fb9 100644
> > --- a/drivers/staging/hv/netvsc.c
> > +++ b/drivers/staging/hv/netvsc.c
> > @@ -525,10 +525,10 @@ int netvsc_send(struct hv_device *device,
> >  						  (unsigned long)packet);
> >  	} else {
> >  		ret = vmbus_sendpacket(device->channel, &sendMessage,
> > -				       sizeof(struct nvsp_message),
> > -				       (unsigned long)packet,
> > -				       VM_PKT_DATA_INBAND,
> > -
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> > +				sizeof(struct nvsp_message),
> > +				(unsigned long)packet,
> > +				VM_PKT_DATA_INBAND,
> > +				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> 
> Why? The arguments were nicely aligned.

Because the last line went beyond 80 chars, and triggered checkpatch warning.

Thanks,
-Haiyang
