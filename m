From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 23/40] Staging: hv: storvsc: Introduce code to manage IDE
 devices using storvsc HBA
Date: Fri, 1 Jul 2011 04:19:32 -0400
Message-ID: <20110701081932.GD28322@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-23-git-send-email-kys@microsoft.com>
 <20110630193843.GB22707@infradead.org>
 <6E21E5352C11B742B20C142EB499E0480816C2EF@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0480816C2EF@TK5EX14MBXC126.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 30, 2011 at 09:38:34PM +0000, KY Srinivasan wrote:
> > > +#define HV_MAX_IDE_DEVICES	4
> > > +#define HV_IDE_BASE_CHANNEL	10
> > > +#define HV_IDE0_DEV1		HV_IDE_BASE_CHANNEL
> > > +#define HV_IDE0_DEV2		(HV_IDE_BASE_CHANNEL + 1)
> > > +#define HV_IDE1_DEV1		(HV_IDE_BASE_CHANNEL + 2)
> > > +#define HV_IDE1_DEV2		(HV_IDE_BASE_CHANNEL + 3)
> > 
> > This at last needs a good explanation of why these devices are called
> > IDE if they actually aren't.  I know you've explained the reason to me
> > before, but it should also be in the code.
> 
> These devices are configured as IDE devices for the guest. The current
> emulator supports 2 IDE controllers for a total of potentially 4 devices.
> I did this to support all these 4 devices under one scsi host and used the
> channel information to get at the correct device in the I/O path.
> So, if you go to a model with one host per device, this would not be required.

Either way the driver should have a nice comment somewhere explaining
why you have disks that are named IDE but handled spoken to using SCSI
with explicit discovery.

> > but more importanly what does path actually stand for here?  Opencoding
> > this into the caller and adding proper comments explaining the scheme
> > might be more readable.
> 
> In the blkvsc driver, the path/target info was used to properly identify the 
> device - (a) the device was under the first or second IDE controller and (b)
> whether it is the first or second device under the controller. 

Yeah, that's what I got from reading the code.  What confuses me is the
"path" terminology which doesn't really map to any normal nomenclature.
