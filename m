From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Vmware crashes if compress/misc.c scrolls?
Date: Wed, 20 Jun 2007 17:46:09 -0700
Message-ID: <4679CA51.3080600@zytor.com>
References: <4679BBCB.2000202@zytor.com> <4679C152.8070407@goop.org>
	<4679C37E.5020908@zytor.com> <4679C497.8090500@goop.org>
	<4679C595.5010905@zytor.com> <4679C5DE.7090700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4679C5DE.7090700@goop.org>
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
> H. Peter Anvin wrote:
>> Jeremy Fitzhardinge wrote:
>>  
>>> You mean "is a real failure"?  Or "is triggered by particular
>>> instructions"?  It seems profoundly bogus (as in, surely DOS or
>>> something reads the framebuffer).
>>>
>>>     
>>
>> A real failure (although only triggered from some variant of protected
>> mode -- paging off?)
>>   
> 
> Oh, it only happens in protected mode?  So the answer to "how does the
> shadow framebuffer get populated?" is "real mode does it before
> switching to protected mode".
> 

Sure, but that means frobbing the boot parameter structure, with
associated problems.  I guess I'm not inherently opposed to it, but I'd
like to understand if there is a cleaner workaround first.

	-hpa
