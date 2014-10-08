From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH RFC 00/11] qemu: towards virtio-1 host support
Date: Tue, 07 Oct 2014 18:24:22 -0700
Message-ID: <54349246.6000905@amacapital.net>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On 10/07/2014 07:39 AM, Cornelia Huck wrote:
> This patchset aims to get us some way to implement virtio-1 compliant
> and transitional devices in qemu. Branch available at
> 
> git://github.com/cohuck/qemu virtio-1
> 
> I've mainly focused on:
> - endianness handling
> - extended feature bits
> - virtio-ccw new/changed commands

At the risk of some distraction, would it be worth thinking about a
solution to the IOMMU bypassing mess as part of this?

--Andy
