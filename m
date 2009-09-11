From: Amit Shah <amit.shah@redhat.com>
Subject: Multiple ports support for virtio_console; major number for dev
Date: Fri, 11 Sep 2009 19:43:05 +0530
Message-ID: <1252678386-17404-1-git-send-email-amit.shah__43417.3591704623$1252678567$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: rusty@rustcorp.com.au
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alan@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org


Hello,

This is the patch that I have for adding support for multiple ports to
virtio_console. It's pretty stable in my testing so far and the memory
corruption that I had earlier has been resolved in linux-next so I'm
proposing this for inclusion.

This currently uses device major number 60 from the experimental range;
Alan could you please reserve a new major number for virtio_console?

Rusty, can you give this a review once more?

Thanks,
		Amit
