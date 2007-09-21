From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/6] virtio with config abstraction and ring
	implementation
Date: Fri, 21 Sep 2007 13:20:11 +1000
Message-ID: <1190344811.19451.47.camel@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<46F2791A.8070601@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F2791A.8070601@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-09-20 at 15:43 +0200, Dor Laor wrote:
> Rusty Russell wrote: 

> >         Drivers now unpack their own configuration: their probe() methods are
> > uniform.  The configuration mechanism is extensible and can be backed by
> > PCI, a string of bytes, or something else.

> I like the separation of the ring code, the improved descriptors and
> the notify too.
> Regarding the pci config space, I rather see config_ops type of
> operations to let 
> the 390/xen/other implementations jump on our wagon.

It's possible to abstract at the find_config() level, but it's also not
too bad to linearize any existing configuration.  I chose to change the
lguest device page to use a linearized format, but I could have adapted
the old device info struct in the kernel without too much hassle:

FYI, here's the lguest snippet, for example:

+struct lguest_config {
+	struct virtio_config_space v;
+
+	/* Status pointer: 4 bytes, then comes the config space itself. */
+	u8 *status;
+};
...
+static void lguest_writeb(struct virtio_config_space *v, unsigned off, u8 b)
+{
+	struct lguest_config *c = container_of(v, struct lguest_config, v);
+
+	c->status[4 + off] = b;
+}
+
+static u8 lguest_readb(struct virtio_config_space *v, unsigned off)
+{
+	struct lguest_config *c = container_of(v, struct lguest_config, v);
+
+	return c->status[4 + off];
+}
+
+static void lguest_set_status(struct virtio_config_space *v, u32 status)
+{
+	struct lguest_config *c = container_of(v, struct lguest_config, v);
+
+	memcpy(c->status, &status, sizeof(status));
+}
+
+static u32 lguest_get_status(struct virtio_config_space *v)
+{
+	struct lguest_config *c = container_of(v, struct lguest_config, v);
+	u32 status;
+
+	memcpy(&status, c->status, sizeof(status));
+	return status;
+}
