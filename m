From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 34/40] Staging: hv: storvsc: Add the contents of
 hyperv_storage.h to storvsc_drv.c
Date: Fri, 1 Jul 2011 12:48:44 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480816C44C@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-34-git-send-email-kys@microsoft.com>
 <20110630194530.GE22707@infradead.org>
 <6E21E5352C11B742B20C142EB499E0480816C297@TK5EX14MBXC126.redmond.corp.microsoft.com>
 <20110701081601.GB28322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110701081601.GB28322@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Friday, July 01, 2011 4:16 AM
> To: KY Srinivasan
> Cc: Christoph Hellwig; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang;
> Abhishek Kane (Mindtree Consulting PVT LTD); Hank Janssen
> Subject: Re: [PATCH 34/40] Staging: hv: storvsc: Add the contents of
> hyperv_storage.h to storvsc_drv.c
> 
> On Thu, Jun 30, 2011 at 08:13:51PM +0000, KY Srinivasan wrote:
> > > > Add the contents of hyperv_storage.h to storvsc_drv.c and cleanup
> > > storvsc_drv.c.n
> > >
> > > I'd at least leave the first half of the header that defines the
> > > protocol around.
> >
> > I only got rid of the block comment at the start of hyperv_storage.h
> > and consolidated the include files. Nothing of substance was deleted.
> 
> I meant to say keeping a separate header file for the protocol defintion
> might be a good idea.  That way it is kept separate from the
> implementation details
> 
Ok; I get it. Although, a while ago as I was cleaning up the header files
In preparation to exiting staging, Greg had indicated that each driver
should, if possible be a single file. I merged the relevant files to comply
with that directive. 

Regards,

K. Y
