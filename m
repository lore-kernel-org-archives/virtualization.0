From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/5] paravirt clock source patches, #4
Date: Tue, 03 Jun 2008 14:42:16 +0100
Message-ID: <48454A38.4090907@goop.org>
References: <1212498439-1283-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1212498439-1283-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.osdl.org, kvm-owner@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> paravirt clock source patches, next round.
>
> There is now a pvclock-abi.h file with the structs and some longish
> comments in it and everybody is switched over to use the stuff in
> there.

This all looks pretty good.  How do you want this to get into the kernel?

    J
