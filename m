From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 13:08:08 -0700
Message-ID: <48E3D8A8.604__13396.6479487301$1222891831$gmane$org@goop.org>
References: <1222881242.9381.17.camel@alok-dev1>
	<48E3BBC1.2050607__35819.6151479662$1222884502$gmane$org@goop.org>
	<48E3D7A0.3000403@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3D7A0.3000403@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Dan Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "avi@redhat.com" <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, akataria@vmware.com, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Mmm, cpuid bikeshedding :-)

My shade of blue is better.

>> The space 0x40000000-0x400000ff is reserved for hypervisor usage.
>>
>> This region is divided into 16 16-leaf blocks.  Each block has the 
>> structure:
>>
>> 0x400000x0:
>>     eax: max used leaf within the leaf block (max 0x400000xf)
>
> Why even bother with this?  It doesn't seem necessary in your proposal.

It allows someone to incrementally add things to their block in a fairly 
orderly way.  But more importantly, its the prevailing idiom, and the 
existing and proposed cpuid schemes already do this, so they'd fit in as-is.

    J
