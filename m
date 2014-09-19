From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 10:39:58 -0700
Message-ID: <CALCETrVY18CexFrNp7j+9fngjTs86gx+3Tav+YihqAQoz8uNZw@mail.gmail.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<b697ef83ae594d8fb34347339dd52dfa@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT1nFrbffotNmLSE0+TVBSR3OChfe5Zu1yPNz0ponznVOQ@mail.gmail.com>
	<CALCETrWCKe2Pfmgu1gi6jMqdyqQ78kCpKawoLbAFgaN2USMksw@mail.gmail.com>
	<1969371640.51211843.1411066715223.JavaMail.zimbra@redhat.com>
	<CALCETrUGS_V2h_beStbVyoTC8vuKiudmJwt55Q2BJg=S2KCNKw@mail.gmail.com>
	<0180a8dfcad746a895755c4374853c16@BY2PR03MB585.namprd03.prod.outlook.com>
	<541B5553.7020203@zytor.com>
	<CALCETrUq71jpO1de4pwbVo+hnE-D2FkuqBDFbdyLiDQzNdENEQ@mail.gmail.com>
	<CAL54oT1Q8kABge=t4s5REVWWakboON-6vfszMRkVz=ks_3vRoA@mail.gmail.com>
	<CALCETrUXz1B=x6rjkQri_qU5Tv-XM5du=rUr-=E-EfNSvOnThg@mail.gmail.com>
	<CALCETrWZ1cF23aT82yGfTKS48d2G+_Od7hEkAzDWzDhqpHNVqA@mail.gmail.com>
	<CAL54oT0sibBiLSHf+eajdRgxqs1jgSzdTTCWBUH9M25ZL10EzA@mail.gmail.com>
	<541C5C8A.6030304@zytor.com>
	<CALCETrWrartDXkWR6Zw4Bx40YdnoB5wJMrWFZfEir+tAKMYNGg@mail.gmail.com>
	<541C699C.5020409@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <541C699C.5020409@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, David Hepkin <davidhep@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 19, 2014 at 10:36 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 09/19/2014 10:21 AM, Andy Lutomirski wrote:
>>>
>>> There is a huge disadvantage to the fact that CPUID is a user space
>>> instruction, though.
>>
>> We can always make cpuid on the leaf in question return all zeros if CPL > 0.
>>
>
> Not sure that is better...

It's better than #GP...

This is why I prefer rdmsr: the privilege semantics are already
appropriate.  Also, I wouldn't be surprised if shoehorning
non-constant results into cpuid implementations might be awkward for
some hypervisors.

--Andy
