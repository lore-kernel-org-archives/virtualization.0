From: Max Krasnyansky <maxk@kernel.org>
Subject: Re: [PATCH 1/1] tun: TUNGETIFF interface to query name and flags
Date: Fri, 15 Aug 2008 11:10:54 -0700
Message-ID: <48A5C6AE.5000804@kernel.org>
References: <1218637816.29159.31.camel@muff>	 <200808141158.57879.rusty@rustcorp.com.au> <1218808944.3751.81.camel@muff>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1218808944.3751.81.camel@muff>
Sender: netdev-owner@vger.kernel.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: netdev <netdev@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Mark McLoughlin wrote:
> On Thu, 2008-08-14 at 11:58 +1000, Rusty Russell wrote:
>> On Thursday 14 August 2008 00:30:16 Mark McLoughlin wrote:
>>> A very simple approach is attached; I did consider doing a TUNGETFLAGS
>>> that would return tun->flags, but I think it's nicer to have a companion
>>> to TUNGETIFF since it also allows one to query the interface name from
>>> the file descriptor.
>> This seems really sensible to me.
>>
>> If Max acks it,
> 
> How about it Max?

Sorry for the delay Mark. I replied to your other email.
ACK.

Max
