From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 1/5] vringfd syscall
Date: Tue, 8 Apr 2008 04:35:53 +0200
Message-ID: <200804080435.54012.arnd__44792.9405411289$1207622278$gmane$org@arndb.de>
References: <200804052202.09157.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804052202.09157.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 05 April 2008, Rusty Russell wrote:
> +asmlinkage long sys_vringfd(void __user *addr,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0unsigned num_descs,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0u16 __user *last_used)
> +{
> +=A0=A0=A0=A0=A0=A0=A0int fd, err;
> +=A0=A0=A0=A0=A0=A0=A0struct file *filp;
> +=A0=A0=A0=A0=A0=A0=A0struct vring_info *vr;
> +
> +=A0=A0=A0=A0=A0=A0=A0/* Must be a power of two, and representable by u16=
 */
> +=A0=A0=A0=A0=A0=A0=A0if (!num_descs || (num_descs & (num_descs-1)) || nu=
m_descs > 65536) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D -EINVAL;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out;
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> +=A0=A0=A0=A0=A0=A0=A0fd =3D get_unused_fd();
> +=A0=A0=A0=A0=A0=A0=A0if (fd < 0) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D fd;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out;
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> +=A0=A0=A0=A0=A0=A0=A0filp =3D alloc_file(vring_mnt, dget(vring_mnt->mnt_=
root), FMODE_WRITE,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0&vring_fops);
> +=A0=A0=A0=A0=A0=A0=A0if (!filp) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D -ENFILE;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto put_fd;
> +=A0=A0=A0=A0=A0=A0=A0}

This looks like a candidate for anon_inode_getfd(), which would let you
get rid of the code for registering your own file system.

	Arnd <><
