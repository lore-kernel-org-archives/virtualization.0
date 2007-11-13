From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 24/24] make vsmp a paravirt client
Date: Tue, 13 Nov 2007 13:33:41 +0100
Message-ID: <200711131333.41946.ak__34652.9812006795$1194957342$gmane$org@suse.de>
References: <11946338683305-git-send-email-gcosta@redhat.com>
	<20071111180709.GG22277@bingen.suse.de> <47398C4A.40806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47398C4A.40806@redhat.com>
Content-Disposition: inline
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
Cc: lguest@ozlabs.org, kiran@scalemp.com, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


> The vsmp_64.c file is now compiled unconditionally, according to which
> me and kiran agreed to. The detection code is always run, but will only
> trigger when a suitable box is found. Accordingly, the paravirt structs
> are only touched when PARAVIRT is on. Otherwise, we don't even have the
> symbols.

That seems dumb. What good is it if it doesn't patch the interrupt code?

-Andi
