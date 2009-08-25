From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 16:45:55 +0300
Message-ID: <20090825134555.GD13949__14726.5381100171$1251208184$gmane$org@redhat.com>
References: <20090824081240.GA3415@redhat.com>
	<20090824212137.GA9835@redhat.com>
	<4A934AF7.2090904@codemonkey.ws> <4A936525.5030300@redhat.com>
	<20090825064604.GB10429@redhat.com>
	<4A93E235.5040008@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A93E235.5040008@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Mark McLoughlin <markmc@redhat.com>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 25, 2009 at 08:08:05AM -0500, Anthony Liguori wrote:
> Once it goes into the upstream  
> kernel, we need to have backwards compatibility code in QEMU forever to  
> support that kernel version.

BTW, qemu can keep doing the userspace thing if some capability it needs
is missing. It won't be worse off than if the driver is not upstream at
all :).

-- 
MST
