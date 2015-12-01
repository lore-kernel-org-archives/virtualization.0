From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/6] Input: Remove vmmouse port reservation
Date: Tue, 1 Dec 2015 14:30:05 -0800
Message-ID: <CAKdAkRTHPSKOePts8cKAHc+PLAgN83skhfPqoDZUvoPXae5-pQ@mail.gmail.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-4-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449008332-9394-4-git-send-email-syeh@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sinclair Yeh <syeh@vmware.com>
Cc: "pv-drivers@vmware.com" <pv-drivers@vmware.com>, X86 ML <x86@kernel.org>, "linux-graphics-maintainer@vmware.com" <linux-graphics-maintainer@vmware.com>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Sinclair,

On Tue, Dec 1, 2015 at 2:18 PM, Sinclair Yeh <syeh@vmware.com> wrote:
> Port reservation is not required.

You need to expand on why we do not need to reserve port.

> Furthermore, this port is shared
> by other VMware services for host-side communication.

What services would that be? Do they reserve the port?

Thanks.

-- 
Dmitry
