From: "Anna, Suman" <s-anna@ti.com>
Subject: RE: [PATCH 1/2] remoteproc: fix kconfig dependencies for VIRTIO
Date: Thu, 18 Apr 2013 15:51:01 +0000
Message-ID: <37C860A02101E749A747FA2D3C1E3C504A4F77__42362.2617767707$1366654625$gmane$org@DLEE11.ent.ti.com>
References: <1366133111-5412-1-git-send-email-s-anna@ti.com>
	<CAK=WgbbfT=Ft3GnN1W5A4fg8BDrypgvfeiM3zoRMbW=JS8m+6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK=WgbbfT=Ft3GnN1W5A4fg8BDrypgvfeiM3zoRMbW=JS8m+6w@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> 
> On Tue, Apr 16, 2013 at 8:25 PM, Suman Anna <s-anna@ti.com> wrote:
> > remoteproc configuration selects VIRTIO, but VIRTIO is now subordinate
> > to VIRTUALIZATION. VIRTUALIZATION has to be selected as well to honor
> > the kconfig menu hierarchy and fix the dependency warnings.
> 
> Thanks Suman. Is this stable material as well or not relevant before 3.9?

No, it is not applicable before 3.9.

Regards
Suman
