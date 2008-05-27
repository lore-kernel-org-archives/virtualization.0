From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/4] Add helper functions for paravirtual clocksources.
Date: Tue, 27 May 2008 15:19:33 +0200
Message-ID: <483C0A65.2090208@redhat.com>
References: <1210924885-5353-1-git-send-email-kraxel@redhat.com>
	<1210924885-5353-2-git-send-email-kraxel@redhat.com>
	<4834A630.7060208@goop.org> <48353DB4.1020303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48353DB4.1020303@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
>> And having defined a common structure, we may as well use it in the
>> hypervisor-specific code/headers so there's no strange casting going on.
> 
> Hmm, what is the state of include/xen/interface/?  It is a straight copy
> of the xen public header files, right?  Is it really ok to modify them?
>  We have to do that to make the cast actually go away ...

ping ...

cheers,
  Gerd

-- 
http://kraxel.fedorapeople.org/xenner/
