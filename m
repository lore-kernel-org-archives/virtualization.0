From: KY Srinivasan <kys@microsoft.com>
Subject: RE: 0xB16B00B5? Really? (was Re: Move hyperv out of the
 drivers/staging/ directory)
Date: Fri, 20 Jul 2012 00:41:37 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9235476BC@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004170415.GA1320@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB86F@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004193414.GA15672@suse.de> <4FFFF711.8040003@redhat.com>
 <426367E2313C2449837CD2DE46E7EAF923547292@SN2PRD0310MB382.namprd03.prod.outlook.com>
 <20120719210709.GA32031@kroah.com>
 <426367E2313C2449837CD2DE46E7EAF9235475EE@SN2PRD0310MB382.namprd03.prod.outlook.com>
 <20120719220142.GA1513@kroah.com>
 <426367E2313C2449837CD2DE46E7EAF923547620@SN2PRD0310MB382.namprd03.prod.outlook.com>
 <20120719232832.GA6317@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120719232832.GA6317@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH (gregkh@linuxfoundation.org)
> [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, July 19, 2012 7:29 PM
> To: KY Srinivasan
> Cc: Paolo Bonzini; devel@linuxdriverproject.org; linux-kernel@vger.kernel.org;
> virtualization@lists.osdl.org
> Subject: Re: 0xB16B00B5? Really? (was Re: Move hyperv out of the
> drivers/staging/ directory)
> 
> On Thu, Jul 19, 2012 at 10:30:38PM +0000, KY Srinivasan wrote:
> > > > As you know, this ID has been in use for a long time now. While the
> hypervisor
> > > > does not interpret the guest ID that is registered, I am not sure what
> > > dependencies
> > > > there might be on this value.
> > >
> > > Could you please go find out the answer to this?
> >
> > That is easier said than done. I have sent emails out asking this very question
> and I have
> > not received a definitive answer yet. Not knowing if and when I can get a
> definitive
> > answer here, I chose the least risky approach in my patch.
> 
> What happens if you test with different values?

Nothing and that is not the issue. Current MSFT hypervisors don't interpret this
ID value while future versions might. However, this ID can be retrieved by the parent
partition and can be used by the management stack today (that is what I am told). 
> 
> > > If, as you originally stated, there is a range of values we can use,
> > > then we should probably use another one, right?
> >
> > On the Windows side this ID namespace is managed well.
> 
> It is?  How is this managed?  What does this tell the hypervisor?  What
> changes with the different values?
> 
> > However on the Linux side, we have really had this current ID in use
> > for almost five years now. I am not aware of any pool of IDs available
> > for Linux usage except that Linux IDs be distinct from the guest IDs
> > in use by MSFT operating systems. If I were to change the guest ID, I
> > would probably want to comply with the MSFT guidance on constructing
> > these IDs (although not all fields may be relevant for Linux).
> 
> What are those rules?

Here is the link that describes how the guest ID should be composed:

http://msdn.microsoft.com/en-us/library/windows/hardware/ff542653%28v=vs.85%29.aspx


Regards,

K. Y
