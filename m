From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 17:06:59 -0700
Message-ID: <541CC523.1030203@zytor.com>
References: <CAL54oT1Q8kABge=t4s5REVWWakboON-6vfszMRkVz=ks_3vRoA@mail.gmail.com>
	<CALCETrUXz1B=x6rjkQri_qU5Tv-XM5du=rUr-=E-EfNSvOnThg@mail.gmail.com>
	<CALCETrWZ1cF23aT82yGfTKS48d2G+_Od7hEkAzDWzDhqpHNVqA@mail.gmail.com>
	<CAL54oT0sibBiLSHf+eajdRgxqs1jgSzdTTCWBUH9M25ZL10EzA@mail.gmail.com>
	<541C5C8A.6030304@zytor.com> <20140919220537.GR26995@thunk.org>
	<CALCETrXct3eqJH7wATfR=H3NrAHXMkydRKsctVhpzZ4jsv87bw@mail.gmail.com>
	<20140919225727.GT26995@thunk.org>
	<CALCETrVbhvB3ExxxNQRB21NYbpvoXgKpX6XxzMKsd=b47rKCeA@mail.gmail.com>
	<541CBC71.6050707@zytor.com> <20140919233502.GV26995@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140919233502.GV26995@thunk.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Mathew John <mathewj@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Andy Lutomirski <luto@amacapital.net>, David Hepkin <davidhep@microsoft.com>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/19/2014 04:35 PM, Theodore Ts'o wrote:
> On Fri, Sep 19, 2014 at 04:29:53PM -0700, H. Peter Anvin wrote:
>>
>> Actually, a much bigger reason is because it lets rogue guest *user
>> space*, even will a well-behaved guest OS, do something potentially
>> harmful to the host.
> 
> Right, but if the host kernel is dependent on the guest OS for
> security, the game is over.  The Guest Kernel must NEVER been able to
> do anything harmful to the host.  If it can, it is a severe security
> bug in KVM that must be fixed ASAP.
> 

"Security" and "resource well-behaved" are two different things.

	-hpa
