From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 24/24] make vsmp a paravirt client
Date: Tue, 13 Nov 2007 10:51:20 -0200
Message-ID: <47399DC8.7000504__29003.9644031369$1194958607$gmane$org@redhat.com>
References: <11946338683305-git-send-email-gcosta@redhat.com>
	<20071111180709.GG22277@bingen.suse.de>
	<47398C4A.40806@redhat.com> <200711131333.41946.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200711131333.41946.ak@suse.de>
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
Cc: lguest@ozlabs.org, kiran@scalemp.com, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen escreveu:
>> The vsmp_64.c file is now compiled unconditionally, according to which
>> me and kiran agreed to. The detection code is always run, but will only
>> trigger when a suitable box is found. Accordingly, the paravirt structs
>> are only touched when PARAVIRT is on. Otherwise, we don't even have the
>> symbols.
> 
> That seems dumb. What good is it if it doesn't patch the interrupt code?

If vsmp is selected, PARAVIRT will be too, and the interrupt code will
be patched.
the vsmp option triggers a select statement.

the ifdef only exists because, as I said, the code itself will be always
compiled in, to avoid an ifdef in setup_64.c. So it's just a taking it
from here, putting it there issue. Kiran seem to prefer this way, but I
don't really have a preference.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Remi - http://enigmail.mozdev.org

iD8DBQFHOZ3IjYI8LaFUWXMRAjPkAJ0XosdyMcj1j4h6XW5dVaj95NH7cgCeIW5o
CGnBnZOTGz9DIu5D997bsZ4=
=BP57
-----END PGP SIGNATURE-----
