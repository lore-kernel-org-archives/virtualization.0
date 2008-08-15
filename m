From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH 1/1] tun: TUNGETIFF interface to query name and flags
Date: Fri, 15 Aug 2008 11:00:19 -0700
Message-ID: <48A5C433.7030002@qualcomm.com>
References: <1218637816.29159.31.camel@muff> <200808141158.57879.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <200808141158.57879.rusty@rustcorp.com.au>
Sender: netdev-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mark McLoughlin <markmc@redhat.com>, netdev <netdev@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Sorry for the delay guys. Was trying to get QEMU USB changes out and was not
paying attention to the other stuff :)

Rusty Russell wrote:
> On Thursday 14 August 2008 00:30:16 Mark McLoughlin wrote:
>> A very simple approach is attached; I did consider doing a TUNGETFLAGS
>> that would return tun->flags, but I think it's nicer to have a companion
>> to TUNGETIFF since it also allows one to query the interface name from
>> the file descriptor.
> 
> This seems really sensible to me.
> 
> If Max acks it, I'd say Dave should merge it.

Makes perfect sense to me.
Definitely Ack. It has zero impact on existing user and I'd be ok if this goes
 in during .27-rc series.

Max


