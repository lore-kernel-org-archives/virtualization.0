From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/3] Split up pv-ops
Date: Thu, 19 Nov 2009 09:42:10 +0200
Message-ID: <4B04F6D2.8080805__30264.6822216504$1258616806$gmane$org@redhat.com>
References: <1258503192-14246-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1258503192-14246-1-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Nick Piggin <npiggin@suse.de>, Glauber Costa <glommer@redhat.com>, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/18/2009 02:13 AM, Alexander Graf wrote:
> Paravirt ops is currently only capable of either replacing a lot of Linux
> internal code or none at all. The are users that don't need all of the
> possibilities pv-ops delivers though.
>
> On KVM for example we're perfectly fine not using the PV MMU, thus not
> touching any MMU code. That way we don't have to improve pv-ops to become
> fast, we just don't compile the MMU parts in!
>
> This patchset splits pv-ops into several smaller config options split by
> feature category and then converts the KVM pv-ops code to use only the
> bits that are required, lowering overhead.
>
> Alexander Graf (3):
>    Split paravirt ops by functionality
>    Only export selected pv-ops feature structs
>    Split the KVM pv-ops support by feature
>
>    

The whole thing looks good to me.  Let's wait for Jeremy to ack though.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
