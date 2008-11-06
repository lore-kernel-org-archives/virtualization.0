From: vgoyal@redhat.com
Subject: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Thu, 06 Nov 2008 10:30:22 -0500
Message-ID: <20081106153022.215696930__3054.24727635018$1225986562$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, jens.axboe@oracle.com, Hirokazu Takahashi <taka@valinux.co>
Cc: Rik van Riel <riel@redhat.com>, Peter Zijlstra <peterz@infradead.org>, fernando@oss.ntt.co.jp, Jeff Moyer <jmoyer@redhat.com>, menage@google.com, ngupta@google.com, Andrew Morton <akpm@linux-foundation.org>, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

If you are not already tired of so many io controller implementations, here
is another one.

This is a very eary very crude implementation to get early feedback to see
if this approach makes any sense or not.

This controller is a proportional weight IO controller primarily
based on/inspired by dm-ioband. One of the things I personally found little
odd about dm-ioband was need of a dm-ioband device for every device we want
to control.  I thought that probably we can make this control per request
queue and get rid of device mapper driver. This should make configuration
aspect easy.

I have picked up quite some amount of code from dm-ioband especially for
biocgroup implementation.

I have done very basic testing and that is running 2-3 dd commands in different
cgroups on x86_64. Wanted to throw out the code early to get some feedback.

More details about the design and how to are in documentation patch.

Your comments are welcome.

Thanks
Vivek

-- 
