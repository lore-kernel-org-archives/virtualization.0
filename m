From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] Split the KVM pv-ops support by feature
Date: Wed, 18 Nov 2009 12:03:39 +1030
Message-ID: <200911181203.39955.rusty__45274.2048343227$1258508140$gmane$org@rustcorp.com.au>
References: <1258503192-14246-1-git-send-email-agraf@suse.de>
	<1258503192-14246-4-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1258503192-14246-4-git-send-email-agraf@suse.de>
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
Cc: Nick Piggin <npiggin@suse.de>, kvm list <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 18 Nov 2009 10:43:12 am Alexander Graf wrote:
> Currently selecting KVM guest support enabled multiple features at once that
> not everyone necessarily wants to have, namely:

These patches make perfect sense, but please make sure Jeremy Fitzhardinge
(CC'd) is in the loop, as he split the structs in the first place.

Thanks!
Rusty.
