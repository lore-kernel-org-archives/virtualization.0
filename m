From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/16] lguest: introduce vcpu structure
Date: Thu, 20 Dec 2007 11:33:40 -0200
Message-ID: <11981576363806-git-send-email-gcosta__18925.00422332$1198157769$gmane$org@redhat.com>
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

this patch makes room for the vcpu structure in lguest, already used in
this very same way at lguest64. It's the first part of our plan to
have lguest and lguest64 unified too. 

When two dogs hang out, you don't have new puppies right in the other day.
Some time has to be elapsed. They have to grow first. In this same spirit, having these 
patches _do not_ mean smp guests can be launched (yet)
Much more work is to come, but this is the basic infrastructure.

Enjoy
