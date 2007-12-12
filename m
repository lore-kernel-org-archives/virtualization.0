From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/6] paravirt patches - the non-integration part
Date: Wed, 12 Dec 2007 10:57:21 -0200
Message-ID: <11974642471600-git-send-email-gcosta__19015.4286021881$1197474880$gmane$org@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This series corresponds do older patches in the paravirt series
that was neither already applied, nor I will touch again. In general,
they do not touch code that can be unified (at least, without being the
unification a big problem on its own).

They passed through this list a lot of times, so I feel them ready for
inclusion, unless someone opposes. 

As with the other patches, they apply to the top of linux-2.6-x86:mm 
