From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [Qemu-devel] Re: virtio: Add memory statistics reporting to the
	balloon driver
Date: Tue, 10 Nov 2009 13:12:02 +1030
Message-ID: <200911101312.02650.rusty__29442.7625755363$1257848192$gmane$org@rustcorp.com.au>
References: <1257782838.2835.5.camel@aglitke>
	<1257784326.2835.16.camel@aglitke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257784326.2835.16.camel@aglitke>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Litke <agl@us.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org, Avi@smtp1.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 10 Nov 2009 03:02:06 am Adam Litke wrote:
> A simpler approach is to collect memory statistics in the virtio
> balloon driver and communicate them to the host via the device config space.

There are two issues I see with this.  First, there's an atomicity problem
since you can't tell when the stats are consistent.  Second, polling is
ugly.

A stats vq might solve this more cleanly?
Rusty.
