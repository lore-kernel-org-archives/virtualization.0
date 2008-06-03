From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/5] paravirt clock source patches, #5
Date: Tue,  3 Jun 2008 16:17:28 +0200
Message-ID: <1212502653-4521-1-git-send-email-kraxel@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, virtualization@lists.osdl.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

paravirt clock source patches, next round.

There is now a pvclock-abi.h file with the structs and some longish
comments in it and everybody is switched over to use the stuff in
there.

Some minor tweaks after super-fast review by Jeremy.

The queue is on top of the kvm git tree.  The first two patches should
have no kvm dependencies and should apply to linus tree just fine.

cheers,
  Gerd

