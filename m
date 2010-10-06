From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: VHOST_NET_SET_BACKEND
Date: Wed, 6 Oct 2010 09:19:32 +0100
Message-ID: <AANLkTindkUcVY_n0dpMh26tUDhPiW_yvJULpdHCKkH1W@mail.gmail.com>
References: <AANLkTin_aMbpop_RQzruqSg5f36nYaChMEzQnG06YHRK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTin_aMbpop_RQzruqSg5f36nYaChMEzQnG06YHRK@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: devi thapa <devi.thapa@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 6, 2010 at 7:43 AM, devi thapa <devi.thapa@gmail.com> wrote:
> =A0 =A0 =A0 I dont know how to put this question, but bear with me. =A0 My
> query is how to invoke the ioctl request "VHOST_NET_SET_BACKEND" =A0or
> how to set the backend, and when ?

Look at the QEMU side vhost-net code:
http://git.qemu.org/qemu.git/tree/hw/vhost_net.c#n145

Where does the backend fd come from?  It's the host network device
file descriptor that gets fetched by vhost_net_get_fd().  Currently it
must be a tap device file descriptor.

Stefan
