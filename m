From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: vhost-blk and qemu
Date: Mon, 23 Nov 2015 16:39:28 +0800
Message-ID: <CAJSP0QU=cmk_06NZWortx+XFj_SMk=hGcyexn-B0TYSEgbVzpg@mail.gmail.com>
References: <1872664481.6220477.1447766581884.JavaMail.yahoo.ref@mail.yahoo.com>
	<1872664481.6220477.1447766581884.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1872664481.6220477.1447766581884.JavaMail.yahoo@mail.yahoo.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mohan G <mohan_gg@yahoo.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 17, 2015 at 9:23 PM, Mohan G via Virtualization
<virtualization@lists.linux-foundation.org> wrote:
> I am looking to experiment the vhost-blk stack. Can some one point me to the
> latest code version and the corresponding qemu version location.
> I am on centos 7 (3.10 ) kernel. I am hoping using the vhost-blk.ko and
> corresponding qemu version will get me started to measure some numbers.

vhost-blk is not under active development.  New revisions of the
patches have not been posted for some time.

You may find the recent vhost-nvme patches from Ming Lin interesting instead:
http://permalink.gmane.org/gmane.linux.kernel.virtualization/26254

Stefan
