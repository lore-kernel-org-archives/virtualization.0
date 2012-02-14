From: Jidong Xiao <jidong.xiao@gmail.com>
Subject: Is there a reference count for ksm shared page?
Date: Mon, 13 Feb 2012 21:17:56 -0500
Message-ID: <CAG4AFWargAT=KuAmwV=Ufx8dqPGoa=k=EPe9d-UzqSEguSiMJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-mm@kvack.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I use madvise() system call to claim that my pages are mergeable, but
for some reason I want to see how many pages are shared with my pages,
is there a way to know that? For example, something like a reference
count.

Thank you!

Jidong
