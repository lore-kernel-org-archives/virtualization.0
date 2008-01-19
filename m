From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/6] lguest patches for compiling x86_64
Date: Fri, 18 Jan 2008 23:59:04 -0200
Message-ID: <1200707950911-git-send-email-gcosta__20887.738679494$1200708061$gmane$org@redhat.com>
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
To: lguest@ozlabs.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Right now, I have lguest in-tree module compiling on x86_64.
It's not yet on a sendable state, since the module itself isn't loading.

However, this subset of the series is pretty straightforward, and I'm sending it
now aiming at reducing the delta size in the future ;-)

Have fun,
