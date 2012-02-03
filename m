From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0000/0004] drivers: hv
Date: Thu,  2 Feb 2012 16:56:17 -0800
Message-ID: <1328230577-3263-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org


This patch-set does some cleanup of the KVP component. Also included is a
patch that will remove artificial limitation on the number of VCPUs that
can be assigned to the Linux guest on Hyper-V. This is a resend of a subset
of the patches that was sent earlier. Of the original 6 patch set,
the first two were applied. I am re-sending the remaining four with
the changes Greg wanted.

Regards,

K. Y
