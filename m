From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Vmware crashes if compress/misc.c scrolls?
Date: Wed, 20 Jun 2007 17:17:02 -0700
Message-ID: <4679C37E.5020908@zytor.com>
References: <4679BBCB.2000202@zytor.com> <4679C152.8070407@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4679C152.8070407@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>> First of all, is this actually true?  This seems like a monumental
>> screwup.
>>   
> 
> Yes.  Is this a report of observed failure?  And how would VMWare even
> go about implementing this kind of misfeature?  Maybe it fails with
> particular instructions reading the framebuffer?

It supposedly is.

>> Second, assuming it is true, what should be done about it?  The notion
>> that the bootloader should erase the screen is ridiculous since we spend
>> a lot of effort maintaining the screen context from 16-bit code.
>>
>> I see a couple of options:
>>   
> 
> Maintain a shadow framebuffer, and copy it to the real framebuffer on
> update...

How would you populate the shadow framebuffer?  Pass it in from real mode?

	-hpa
