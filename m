From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/2] Paravirt loops per jiffy calculation
Date: Wed, 23 Jul 2008 12:07:43 +0200
Message-ID: <488702EF.7060305__6313.27823871306$1216807822$gmane$org@redhat.com>
References: <1216743328-3213-1-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1216743328-3213-1-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <gcosta@redhat.com>
Cc: aliguori@codemonkey.ws, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> Turns out that only implementing a pv get_tsc_khz is not enough, since
> it will only do the right thing for cpu0, which is not what we desire.
> 
> So we set preset_lpj. Recall this code is run before arch parameter setup,
> so if we pass lpj=xx in the command line, it'll still work.

Hmm, why kvm needs the preset_lpj thing and xen doesn't?

cheers,
  Gerd

-- 
http://kraxel.fedorapeople.org/xenner/
