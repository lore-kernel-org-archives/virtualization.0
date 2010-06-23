From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH for-2.6.35] virtio-pci: disable msi at startup
Date: Wed, 23 Jun 2010 17:21:37 +0300
Message-ID: <4C221871.6020509@redhat.com>
References: <20100610152252.GA3510@redhat.com> <4C22132F.4060307@redhat.com>
	<20100623135946.GA30526@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100623135946.GA30526@redhat.com>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-pci@vger.kernel.org, Matt Carlson <mcarlson@broadcom.com>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/23/2010 04:59 PM, Michael S. Tsirkin wrote:
>
>> Why doesn't a device reset result in msi being cleared?
>>      
> This is not a standard function reset. This is virtio specific
> command. So it only clears virtio registers.
>    

I see.  We should implement FLR in qemu.  If we don't already do so, we 
should probably FLR anything that moves when a kexec kernel starts.

>> Shouldn't a reset be equivalent to power cycling?
>>      
> If we did this, driver would need to restore registers
> such as BAR etc.
>    

We could save/restore the registers we care about.

-- 
error compiling committee.c: too many arguments to function
