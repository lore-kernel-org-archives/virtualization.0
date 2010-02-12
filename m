From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: document MSI-X
Date: Fri, 12 Feb 2010 20:17:55 +1030
Message-ID: <201002122017.55536.rusty__8333.31951075724$1265968116$gmane$org@rustcorp.com.au>
References: <20100211172236.GA20357@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100211172236.GA20357@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: markmc@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 12 Feb 2010 03:52:36 am Michael S. Tsirkin wrote:
> This documents MSI-X support in virtio.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Wow, great!

I reworked one paragraph for better grammar.  Mainly adding "the":

(pseudo-patch):
    Devices report such failures by returning +the+ NO_VECTOR value
    when the relevant Vector field is read. After mapping an event to vector,
    +the+ driver must verify success by reading the Vector field value: on
    success, +the+ previously written value is returned-;-+, and+ on failure,
    NO_VECTOR -value- is returned. If +a+ mapping failure is detected, +the+
    driver can retry mapping with +fewer+-less- vectors, or disable MSI-X.

I really liked the conversational style: standards can be intimidating and
unfriendly documents if they concentrate too much on partitioning all
information into precise sections.

That makes it 0.8.6.  I will re-read the entire document for consistency
before releasing 0.9.

Thanks!
Rusty.
