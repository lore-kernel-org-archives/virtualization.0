From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 24/24] make vsmp a paravirt client
Date: Tue, 13 Nov 2007 14:09:41 +0100
Message-ID: <200711131409.41959.ak__46110.9058851891$1194959598$gmane$org@suse.de>
References: <11946338683305-git-send-email-gcosta@redhat.com>
	<200711131333.41946.ak@suse.de> <47399DC8.7000504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47399DC8.7000504@redhat.com>
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


> If vsmp is selected, PARAVIRT will be too, and the interrupt code will
> be patched.
> the vsmp option triggers a select statement.
> 
> the ifdef only exists because, as I said, the code itself will be always
> compiled in, to avoid an ifdef in setup_64.c. So it's just a taking it
> from here, putting it there issue.

Peeking around needlessly in pci config space at each boot just to avoid an 
ifdef is not an good idea.

-Andi
