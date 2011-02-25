From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Can't build in the virtio console driver on x86_64 when the
	other virtio drivers are modular
Date: Fri, 25 Feb 2011 11:38:15 +0530
Message-ID: <20110225060815.GB15723__25921.1682052866$1298614158$gmane$org@amit-x200.redhat.com>
References: <20110224112819.10f59f68@katamari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110224112819.10f59f68@katamari>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 24 Feb 2011 [11:28:19], Chuck Ebbert wrote:
> The virtio configuration options are inconsistent. According to this,
> every options that needs virtio will select it:
> 
>  # Virtio always gets selected by whoever wants it.
>  config VIRTIO
>         tristate
> 
> Note that it's not user-selectable, so any config file that tries to
> set it will be ignored when kconfig loads those options. And yet we
> have a whole set of options that depend on VIRTIO, like VIRTIO_CONSOLE
> for example. This makes it impossible to have VIRTIO_PCI modular and
> VIRTIO_CONSOLE built-in on x86_64, because:

Any reason to have VIRTIO_PCI modular instead of built in (on x86-64,
virtio-console won't work without virtio-pci anyway)?

		Amit
