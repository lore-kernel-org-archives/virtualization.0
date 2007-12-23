From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [Virtio-for-kvm] [PATCH 0/7] userspace virtio
Date: Sun, 23 Dec 2007 12:52:46 +0200
Message-ID: <476E3DFE.6010404__23905.3558129401$1198407329$gmane$org@qumranet.com>
References: <476BD0E4.3040509@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <476BD0E4.3040509@qumranet.com>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dor Laor wrote:
> This patchset updates kvm repository with Anthony's virtio 
> implementation along
> with rx performance improvements and guest reset handling.
> The original code was sent to qemu devel list 2 weeks ago.
> It contains support for network & block devices.
>
> Using the performance improvement I was able to do 800Mbps for rx/tx.
> The performance improvement are not implemented in a qemu standard code but
> the intention is to first let the community have decent performance with 
> a merged virtio and
> afterwards do the polishing (there is dma support on the way for qemu).
>
> Enjoy [with the courtesy of Anthony & Rusty],
>   

General comments for the patchset:
- please use git send-email or attach patches; your email client mangles 
whitespace
- add your sign off even on patches that you did not write or change


-- 
error compiling committee.c: too many arguments to function
