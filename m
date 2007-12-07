From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/3] Unify segment headers
Date: Fri,  7 Dec 2007 14:22:39 -0200
Message-ID: <119704456265-git-send-email-gcosta__546.828730921511$1197054724$gmane$org@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Hi,

In this patch, I unify segment_32.h and segment_64.h into segment.h
They have some common parts, but a considerable ammount of code still has
to be around ifdefs. 

The only patch that is really important to paravirt is the first one, that
moves a paravirt definition into the common header. The other two are just
normal integration, and pretty much independent
