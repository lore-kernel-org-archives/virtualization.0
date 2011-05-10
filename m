From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 115/206] Staging: hv: Use completion abstraction in
 struct netvsc_device
Date: Tue, 10 May 2011 12:52:07 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481EEFD6@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-115-git-send-email-kys@microsoft.com>
 <20110510070646.GB13847@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110510070646.GB13847@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Tuesday, May 10, 2011 3:07 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang;
> Abhishek Kane (Mindtree Consulting PVT LTD); Hank Janssen
> Subject: Re: [PATCH 115/206] Staging: hv: Use completion abstraction in struct
> netvsc_device
> 
> > -	net_device->wait_condition = 0;
> >  	ret = vmbus_sendpacket(device->channel, init_packet,
> >  			       sizeof(struct nvsp_message),
> >  			       (unsigned long)init_packet,
> > @@ -272,10 +272,8 @@ static int netvsc_init_recv_buf(struct hv_device
> *device)
> >  		goto cleanup;
> >  	}
> >
> > -	wait_event_timeout(net_device->channel_init_wait,
> > -			net_device->wait_condition,
> > -			msecs_to_jiffies(1000));
> > -	BUG_ON(net_device->wait_condition == 0);
> > +	t = wait_for_completion_timeout(&net_device->channel_init_wait, HZ);
> > +	BUG_ON(t == 0);
> 
> I don't think you want a BUG_ON here, but rather fail the
> initialization.

This is existing code and all I did was change the synchronization 
primitive used. Back in Feb. when this was done (prior to then), the 
wait was indefinite and one of the comments that was
longstanding was  that the wait had to be bounded and so these 
timed waits were introduced. When this was done,  
in some cases, there was no easy way to roll-back state if we did not
get the response within our expected window of time. This is one 
such instance where the guest is handing over the receive buffers
(guest physical addresses) to the host. There was a discussion on this very
topic on this mailing list and the consensus was to leave the BUG_ON()
call in cases where we could not reasonably recover. 
 
> 
> Also I think you really should add synchronous versions of
> vmbus_sendpacket*, to the vmbus core so that all the synchronous waiting
> can be consolidated into a few helpers instead of needing to opencode
> it everywhere.

True; but having a non-blocking interface at the lowest level gives you
the most flexibility. In addition to this non-blocking interface, we
may want to look at potentially a blocking interface. In the current
code, the blocking primitive that is embedded in a higher level 
abstraction is used for a variety of situations including the initial
handshake which is what can be addressed with a synchronous API
at the lowest level.

Regards,

K. Y
