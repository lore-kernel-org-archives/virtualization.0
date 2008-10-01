From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 11:12:19 -0700
Message-ID: <48E3BD83.2090801__37061.516106087$1222885000$gmane$org@goop.org>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<48E3BC47.60900@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3BC47.60900@zytor.com>
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
Cc: kvm@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Dan Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "avi@redhat.com" <avi@redhat.com>, akataria@vmware.com, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
>>
>> No, we're not getting anywhere.  This is an outright broken idea.  
>> The space is too small to be able to chop up in this way, and the 
>> number of vendors too large to be able to do it without having a 
>> central oversight.
>>
>
> I suspect we can get a larger number space if we ask Intel & AMD.  In 
> fact, I think we should request that the entire 0x40xxxxxx numberspace 
> is assigned to virtualization *anyway*.

Yes, that would be good.  In that case I'd revise my proposal to back 
each leaf block 256 leaves instead of 16.  But it still needs to be a 
proper enumeration with signatures, rather than assigning fixed points 
in that space to specific interfaces.

    J
