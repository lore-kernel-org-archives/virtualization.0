From: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and	Linux.
Date: Thu, 02 Oct 2008 14:29:00 +0300
Message-ID: <48E4B07C.60605__6747.57074234567$1222959087$gmane$org@redhat.com>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<1222894878.9381.63.camel@alok-dev1>
	<48E3E8DE.1080602@goop.org> <48E3ECD1.30809@codemonkey.ws>
	<20081001214338.GD634@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081001214338.GD634@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Anthony Liguori <anthony@codemonkey.ws>, "H. Peter Anvin" <hpa@zytor.com>, akataria@vmware.com, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Anthony Liguori (anthony@codemonkey.ws) wrote:
>   
>> And arguably, storing TSC frequency in CPUID is a terrible interface  
>> because the TSC frequency can change any time a guest is entered.  It  
>>     
>
> True for older hardware, newer hardware should fix this.  I guess the
> point is, the are numbers that are easy to measure incorrectly in guest.
> Doesn't justify the whole thing..
>   

It's not fixed for newer hardware.  Larger systems still have multiple 
tsc frequencies.

-- 
error compiling committee.c: too many arguments to function
