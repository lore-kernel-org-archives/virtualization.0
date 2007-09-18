From: Charles N Wyble <charles@thewybles.com>
Subject: Re: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Tue, 18 Sep 2007 13:27:20 -0700
Message-ID: <46F034A8.2070801__35581.8160729997$1190147317$gmane$org@thewybles.com>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<200709181257.41530.ak@suse.de> <46F02F50.5000001@thewybles.com>
	<200709182220.27311.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709182220.27311.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <aliguori@us.ibm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Andi Kleen wrote:
> 
>> 	Why is making something default y a bad idea? 
>> Those most likely to care can turn it off. Is there a harmful effect
>> from leaving it on if its not being used?
> 
> Running yes "" | make oldconfig to upgrade kernel configs is standard practice
> and you definitely don't want to have all kinds of random new unnecessary features
> be turned on then.

Hmmmm. I disagree its a standard practice. I thought the whole point of
make oldconfig was to give you just the delta in configuration options
and was targeted at manual review?

Also how many people are building there own kernels these days?
Expanding on what I said in the original e-mail those who are likely to
care "CAN TURN IT OFF". Those who care about such things should be
REVIEWING CHANGES anyway. Thats what I do when looking at building
custom kernels. What changed that makes me want to move to a new version?

I generally try to stick with the distro kernel when possible, but part
of being an early and aggressive adopter of virtualization technology
involves running non distro kernels and patches.

Most people don't really care.

> 
> Besides paravirt by itself is pretty useless; you need typically quite
> complex other options set to do any meaningfull virtualization.

Actually if I understand the functionality of paravirt correctly that is
not correct. I believe that will turn on the paravirt bits which allow
it to run under things such as VMI or Xen.

> 
> The only reason to use default y is in options that are not user visible
> and have a reasonable default or things that cause direct boot failures
> when upgrading old configurations. That all doesn't apply here.

Again you need to think about the target audience here. A distro kernel
you don't have to worry about this stuff. A user compiling there own
kernel should already be able to handle this.

> 
> Besides it's bad taste and taste is very important.

Well it's bad taste for you (one person). Taste is highly subjective. So
be careful in making broad ranging statements like this. :)

> 
> -Andi
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG8DSnkQPZV56XDBMRAtZcAJ4rtRXGW14b70YRIBKyHCsaKTdO/wCeOdoM
AUc4YGUaqs5DmDDbov7X980=
=UA4y
-----END PGP SIGNATURE-----
