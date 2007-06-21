From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Vmware crashes if compress/misc.c scrolls?
Date: Wed, 20 Jun 2007 17:21:43 -0700
Message-ID: <4679C497.8090500@goop.org>
References: <4679BBCB.2000202@zytor.com> <4679C152.8070407@goop.org>
	<4679C37E.5020908@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4679C37E.5020908@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
>   
>> Yes.  Is this a report of observed failure?  And how would VMWare even
>> go about implementing this kind of misfeature?  Maybe it fails with
>> particular instructions reading the framebuffer?
>>     
>
> It supposedly is.
>   

You mean "is a real failure"?  Or "is triggered by particular 
instructions"?  It seems profoundly bogus (as in, surely DOS or 
something reads the framebuffer).

>> Maintain a shadow framebuffer, and copy it to the real framebuffer on
>> update...
>>     
>
> How would you populate the shadow framebuffer?  Pass it in from real mode?
>   

Erm.  BIOS always says basically the same stuff, so just compile a 
screenshot into the setup code?

    J
