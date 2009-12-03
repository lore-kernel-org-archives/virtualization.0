From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/3] Split up pv-ops
Date: Thu, 03 Dec 2009 15:52:55 +0100
Message-ID: <4B17D0C7.1020805__14940.1858835065$1259852043$gmane$org@suse.de>
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
To: kvm list <kvm@vger.kernel.org>
Cc: Nick Piggin <npiggin@suse.de>, Glauber Costa <glommer@redhat.com>, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Alexander Graf wrote:
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

So has this ended up in some tree yet?
