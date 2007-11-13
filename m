From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 24/24] make vsmp a paravirt client
Date: Tue, 13 Nov 2007 09:21:51 -0800
Message-ID: <4739DD2F.5060605__45151.8041118563$1194974779$gmane$org@goop.org>
References: <11946338683305-git-send-email-gcosta@redhat.com>	<20071111180709.GG22277@bingen.suse.de>	<47398C4A.40806@redhat.com>
	<200711131333.41946.ak@suse.de> <47399DC8.7000504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47399DC8.7000504@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, mingo@elte.hu, Andi Kleen <ak@suse.de>, kiran@scalemp.com, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, tglx@linutronix.de, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> the ifdef only exists because, as I said, the code itself will be always
> compiled in, to avoid an ifdef in setup_64.c. So it's just a taking it
> from here, putting it there issue. Kiran seem to prefer this way, but I
> don't really have a preference.

It would be better to have the ifdef in setup_64.c and just make the
compilation of vsmp_64.c depend on CONFIG_X86_VSMP.  If the ifdef really
rankles you could use a weak stub function somewhere, or define an
inline stub in vsmp.h.

    J
