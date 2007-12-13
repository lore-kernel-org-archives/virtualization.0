From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/19 - v3] desc_struct integration
Date: Thu, 13 Dec 2007 00:01:33 -0200
Message-ID: <11975113122984-git-send-email-gcosta__11995.726338546$1197521364$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1196957800568-git-send-email-gcosta@redhat.com>
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

Here it goes a new version of the patchset.

It addresses the problems raised, namely:
* it does not harm make headers_check anymore. (fill_ldt is moved to desc.h)
* it fixes the x86_64 spontaneous boot problem
* it does not have a warning at get_desc_base() anymore.
