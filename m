From: Amos Kong <akong@redhat.com>
Subject: Re: [RFC PATCH 0/2] make mac programming for virtio net more robust
Date: Thu, 10 Jan 2013 23:08:09 +0800
Message-ID: <20130110150809.GA19497@t430s.redhat.com>
References: <1357829141-25455-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1357829141-25455-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, rusty@rustcorp.com.au
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 10, 2013 at 10:45:39PM +0800, akong@redhat.com wrote:
> From: Amos Kong <akong@redhat.com>
> 
> Currenly mac is programmed byte by byte. This means that we
> have an intermediate step where mac is wrong. 
> 
> Second patch introduced a new vq control command to set mac
> address in one time.

I just posted RFC patches (kernel & qemu) out,
specifiction update will be sent when the solution
is accepted.

MST has another solution:
1. add a feature to disable mac address in pci space
2. introduce a new vq control cmd to add new mac address
   to mac filter table. (no long check n->mac in receiver_filter())

Welcome to give comments, thanks!
Amos
