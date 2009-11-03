From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv6 1/3] tun: export underlying socket
Date: Tue, 3 Nov 2009 13:41:31 +0100
Message-ID: <200911031341.31622.arnd__29625.0370717191$1257252276$gmane$org@arndb.de>
References: <cover.1257193660.git.mst@redhat.com>
	<200911031312.33580.arnd@arndb.de>
	<20091103123112.GA4961@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091103123112.GA4961@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 November 2009, Michael S. Tsirkin wrote:
> > What was your reason for changing?
> 
> It turns out socket structure is really bound to specific a file, so we
> can not have 2 files referencing the same socket.  Instead, as I say
> above, it's possible to make sendmsg/recvmsg work on tap file directly.

Ah, I see.

> I have implemented this (patch below), but decided to go with the simple
> thing first.  Since no userspace-visible changes are involved, let's do
> this by small steps: it will be easier to figure out when vhost
> is upstream.

This may even make it easier for me to do the same with macvtap
if I resume work on that.

> @@ -416,8 +422,8 @@ int sock_map_fd(struct socket *sock, int flags)
>  
>  static struct socket *sock_from_file(struct file *file, int *err)
>  {
> -       if (file->f_op == &socket_file_ops)
> -               return file->private_data;      /* set in sock_map_fd */
> +       if (file->f_op->get_socket)
> +               return file->f_op->get_socket(file);
>  
>         *err = -ENOTSOCK;

Or maybe do both (socket_file_ops and get_socket), to avoid an indirect
function call.

	Arnd <><
