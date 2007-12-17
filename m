From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/21] Integrate processor.h
Date: Mon, 17 Dec 2007 20:52:23 -0200
Message-ID: <11979319641796-git-send-email-gcosta__49608.1147496172$1197941874$gmane$org@redhat.com>
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

This series integrate the processor.h header. There are a lot of things
that are deeply architectural differences between architectures, but
I've done my best to come to a settlement. 

With this series, I am very close to have selectable paravirt for x86_64,
It applies ontop of today's x86 git, mm branch.
