From: Christoph Hellwig <hch@infradead.org>
Subject: Re: virtio-gpu without ARCH_HAS_SG_CHAIN
Date: Tue, 30 Oct 2018 23:12:06 -0700
Message-ID: <20181031061206.GA2828__42966.4175412201$1540966207$gmane$org@infradead.org>
References: <CAGw6cBsWHB4aRf=kPoT+v-FbtL0ymeBtZNEwKYobFizc0cLeaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGw6cBsWHB4aRf=kPoT+v-FbtL0ymeBtZNEwKYobFizc0cLeaQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Forney <mforney@mforney.org>
Cc: linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There is no good reason to not define ARCH_HAS_SG_CHAIN.  To fix
your immediate problem just select it from riscv, as riscv uses
the generic dma-direct code which is chained S/G safe by definition.

And if you want to get extra points do a quick audit of the remaning
iommu drivers on architectures that don't define it so that we can
kill the symbol.
