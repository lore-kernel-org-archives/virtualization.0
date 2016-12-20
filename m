From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/ttm: use designated initializers
Date: Tue, 20 Dec 2016 11:55:38 -0800
Message-ID: <CAGXu5jKdVnho0vEgLHOCCoQZAKu4fm600ZzuSSyyiDLsuvgc2A@mail.gmail.com>
References: <20161217005929.GA140260@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161217005929.GA140260@beast>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Dec 18, 2016 at 10:53 PM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> Hello Kees,
>
> While understanding what your patches (I've seen the other ones as well) do
> themself, I still don't get what your intention is, e.g. why you need this?
> Apart from a better readability.
>
> On Friday 16 December 2016 16:59:29, Kees Cook wrote:
>> Prepare to mark sensitive kernel structures for randomization by making
>> sure they're using designated initializers.
>
> Can you please elaborate what you mean with that sentence?

Hi! Sure: the coming (and optional) gcc plugin "randstruct" performs
structure layout randomization, which means that static initializers
cannot be "ordered" (they must be "designated"), since the place were
layout randomization occurs happens separate from how static
initializers are applied.

This change from ordered to designated is just to help the compiler do
the right thing.

-Kees

-- 
Kees Cook
Nexus Security
